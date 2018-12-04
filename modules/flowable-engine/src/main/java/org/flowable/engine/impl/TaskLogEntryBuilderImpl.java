/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.flowable.engine.impl;

import org.flowable.common.engine.impl.interceptor.CommandExecutor;
import org.flowable.engine.impl.cmd.AddTaskLogEntryCmd;
import org.flowable.task.api.TaskInfo;
import org.flowable.task.service.impl.BaseTaskLogEntryBuilderImpl;

/**
 * @author martin.grofcik
 */
public class TaskLogEntryBuilderImpl extends BaseTaskLogEntryBuilderImpl {

    public TaskLogEntryBuilderImpl(CommandExecutor commandExecutor, TaskInfo task) {
        super(commandExecutor, task);
    }

    public TaskLogEntryBuilderImpl(CommandExecutor commandExecutor) {
        super(commandExecutor);
    }

    @Override
    public void add() {
        this.commandExecutor.execute(new AddTaskLogEntryCmd(this));
    }
}
