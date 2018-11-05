# vim: ft=zsh ts=2 sw=2
async_start_worker kubectl_worker -n

completed_callback() {
	source <(kubectl completion zsh)
	async_stop_worker kubectl_worker
}

async_register_callback kubectl_worker completed_callback
async_job kubectl_worker sleep 1
