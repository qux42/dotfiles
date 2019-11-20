# vim: ft=zsh ts=2 sw=2
async_start_worker helm_worker -n

completed_callback_helm() {
	source <(helm completion zsh)
	async_stop_worker helm_worker
}

async_register_callback helm_worker completed_callback_helm
async_job helm_worker sleep 1
