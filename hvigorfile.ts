import { appTasks } from '@ohos/hvigor-ohos-plugin';
import { commitMsgPlugin } from './scripts/git_hooks/commit_msg/commit_msg_plugin.js'

commitMsgPlugin()

export default {
  system: appTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: []       /* Custom plugin to extend the functionality of Hvigor. */
}