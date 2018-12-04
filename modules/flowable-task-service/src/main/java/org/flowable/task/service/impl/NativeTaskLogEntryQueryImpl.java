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
package org.flowable.task.service.impl;

import java.util.List;
import java.util.Map;

import org.flowable.common.engine.impl.interceptor.CommandContext;
import org.flowable.common.engine.impl.interceptor.CommandExecutor;
import org.flowable.task.api.NativeTaskLogEntryQuery;
import org.flowable.task.api.TaskLogEntry;
import org.flowable.task.service.impl.util.CommandContextUtil;

/**
 * @author martin.grofcik
 */
public class NativeTaskLogEntryQueryImpl extends AbstractNativeQuery<NativeTaskLogEntryQuery, TaskLogEntry> implements NativeTaskLogEntryQuery {

    private static final long serialVersionUID = 1L;

    public NativeTaskLogEntryQueryImpl(CommandContext commandContext) {
        super(commandContext);
    }

    public NativeTaskLogEntryQueryImpl(CommandExecutor commandExecutor) {
        super(commandExecutor);
    }

    // results ////////////////////////////////////////////////////////////////

    @Override
    public List<TaskLogEntry> executeList(CommandContext commandContext, Map<String, Object> parameterMap) {
        return CommandContextUtil.getTaskLogEntryEntityManager(commandContext).findTaskLogEntriesByNativeQueryCriteria(parameterMap);
    }

    @Override
    public long executeCount(CommandContext commandContext, Map<String, Object> parameterMap) {
        return CommandContextUtil.getTaskLogEntryEntityManager(commandContext).findTaskLogEntriesCountByNativeQueryCriteria(parameterMap);
    }

}
