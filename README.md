# Kubernetes Privilege Escalation Check

This action checks k8s workload privilege escalation when a PR is open

## Inputs

### `sourceDir`

**Required** The source directory for k8s workload yaml. (master branch)

### `targetDir`

**Required** The target directory for k8s workload yaml. (PR branch)

## Outputs

### `escalation_report`

Privilege escalation report
- 1: Priviege Escalated
- 0: No Change
- -1: Privilege Reduced
```
{
    "escalation": true,
    "reduction": false,
    "privileged": 1,
    "hostIPC": 1,
    "hostNetwork": 1,
    "hostPID": 1,
    "new_hostpaths": {},
    "removed_hostpaths": {},
    "new_volume_types": [],
    "removed_volume_types": [],
    "new_capabilities": [
        "SYS_ADMIN",
        "SYS_CHROOT"
    ],
    "reduced_capabilities": [],
    "run_as_user_strategy": 1,
    "un_as_group_strategy": 0,
    "read_only_root_fs": 1
}
```

## Example usage
```
# checkout master branch
- uses: actions/checkout@v2
    with:
      ref: master
      path: master
# checkout PR branch
- uses: actions/checkout@v2
    with:
      path: candidate
      ref: ${{ github.event.pull_request.head.sha }}
# pass the yamls directory to k8s-privilege-check git action
- name: K8s workload privilege escalation check
  uses: Kaizhe/k8s-privilege-check@v1.0.0
  with:
    sourceDir: '/master/yamls'
    targetDir: '/candidate/yamls'
# evaluate escalation report
- name: Post Privilege Check
  run: |
    echo ${{ toJSON(steps.k8s_privilege_check.outputs.escalation_report) }}
    # slack
    # or other git action like adding another reviewer
```
