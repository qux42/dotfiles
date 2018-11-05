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

es_tunnel () {
	if [[ -z ${1} ]];	then
		kubectl config get-contexts
	else
		CONTEXT=${1}
		kubectl --context ${CONTEXT} port-forward --namespace storage $(kubectl --context ${CONTEXT} get --namespace storage pods | grep es-storage | cut -d' '  -f1 | tail -1) 9200:9200
	fi
}
