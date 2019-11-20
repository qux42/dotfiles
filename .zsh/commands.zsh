# vim: ft=zsh ts=2 sw=2
k8_set_namespace () {
	if [[ -z ${1} ]];	then
		kubectl get namespace
	else
		kubectl config set-context $(kubectl config current-context) --namespace=${1}
		echo "Set namespace to $(kubectl config view --context $(kubectl config current-context) | grep namespace: | tail -n 1 | awk '{print $NF}')."
	fi
}

k8_set_context () {
	if [[ -z ${1} ]];	then
		kubectl config get-contexts
	else
    mcs_switch_binaries $1
		kubectl config use-context $1 --namespace=default
	fi
}

mcs_tunnel () {
	if [[ -z ${1} ]];	then
		kubectl config get-contexts
	else
		CONTEXT=${1}
		kubectl --context ${CONTEXT} port-forward --namespace storage $(kubectl --context ${CONTEXT} get --namespace storage pods | grep stolon-proxy | cut -d' '  -f1 | tail -1) 45432:5432
	fi
}


mcs_switch_binaries () {
  case $1 in
    *-dom)
      set_k8_env azure
      ;;
    *)
      set_k8_env profitbricks
      ;;
  esac
}

set_k8_env () {
  unset_k8_env
  if [[ -d /opt/kubernetes/kubernetes-env-${1} ]]; then
    export PATH=/opt/kubernetes/kubernetes-env-${1}:$PATH
    echo "Now using binaries from /opt/kubernetes/kubernetes-env-${1}"
  else
    echo "Error: Directory /opt/kubernetes/kubernetes-env-${1} does not exist!"
    exit 1
  fi
}

unset_k8_env () {
  export PATH="$( echo $PATH | tr : '\n' | grep -v /opt/kubernetes/kubernetes-env | paste -s -d: -)"
}


mcs_debug () {
    POD=${1}
		kubectl port-forward  $(kubectl get pods | grep ${POD} | cut -d' '  -f1 | tail -1) 5005:5005
}
mcs_log () {
    POD=${1}
		kubectl log -f --tail 100  $(kubectl get pods | grep ${POD} | cut -d' '  -f1 | tail -1)
}

es_tunnel () {
	if [[ -z ${1} ]];	then
		kubectl config get-contexts
	else
		CONTEXT=${1}
		kubectl --context ${CONTEXT} port-forward --namespace storage $(kubectl --context ${CONTEXT} get --namespace storage pods | grep es-storage | cut -d' '  -f1 | tail -1) 9200:9200
	fi
}


user_info () {
  ~/repos/miele/mcs-stuff/migration/user_info.sh $@
}
