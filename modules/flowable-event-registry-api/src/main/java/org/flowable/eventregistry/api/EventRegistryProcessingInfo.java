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
package org.flowable.eventregistry.api;

import java.util.ArrayList;
import java.util.List;
import java.util.StringJoiner;

public class EventRegistryProcessingInfo {

    protected List<EventConsumerInfo> eventConsumerInfos;
    
    public boolean eventHandled() {
        return eventConsumerInfos != null && !eventConsumerInfos.isEmpty();
    }
    
    public void addEventConsumerInfo(EventConsumerInfo eventInfo) {
        if (eventConsumerInfos == null) {
            eventConsumerInfos = new ArrayList<>();
        }
        
        eventConsumerInfos.add(eventInfo);
    }

    public List<EventConsumerInfo> getEventConsumerInfos() {
        return eventConsumerInfos;
    }

    public void setEventConsumerInfos(List<EventConsumerInfo> eventConsumerInfos) {
        this.eventConsumerInfos = eventConsumerInfos;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", getClass().getSimpleName() + "[", "]")
                .add("eventConsumerInfos=" + eventConsumerInfos)
                .toString();
    }
}
