const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const os = require('os');

function commitMsgPlugin() {
  const HOOK_NAME = 'commit-msg';
  const HOOK_SOURCE = path.resolve(__dirname, HOOK_NAME);
  const GIT_HOOK_TARGET = path.resolve(__dirname, '../../../.git/hooks', HOOK_NAME);

  // console.log(HOOK_SOURCE, GIT_HOOK_TARGET)

  if (fs.existsSync(GIT_HOOK_TARGET)) {
    // 已存在校验脚本则直接return
    return;
  }

  // 拷贝脚本到 hooks 目录
  fs.copyFileSync(HOOK_SOURCE, GIT_HOOK_TARGET);

  // 添加执行权限
  if (os.platform() !== 'win32') {
    execSync(`chmod +x ${GIT_HOOK_TARGET}`);
  }

  console.log(`Git hook installed successfully: ${HOOK_NAME}`);

}

module.exports = { commitMsgPlugin };