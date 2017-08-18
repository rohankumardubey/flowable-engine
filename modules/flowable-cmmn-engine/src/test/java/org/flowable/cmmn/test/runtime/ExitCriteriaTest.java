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
package org.flowable.cmmn.test.runtime;

import static org.junit.Assert.assertEquals;

import java.util.List;

import org.flowable.cmmn.engine.runtime.CaseInstance;
import org.flowable.cmmn.engine.runtime.PlanItemInstance;
import org.flowable.cmmn.engine.test.CmmnDeployment;
import org.flowable.cmmn.engine.test.FlowableCmmnTestCase;
import org.junit.Test;

/**
 * @author Joram Barrez
 */
public class ExitCriteriaTest extends FlowableCmmnTestCase {

    @Test
    @CmmnDeployment
    public void testSimpleExitCriteriaBlocking() {
        CaseInstance caseInstance = cmmnRuntimeService.startCaseInstanceByKey("myCase");
        List<PlanItemInstance> planItems = cmmnRuntimeService.createPlanItemQuery()
                .caseInstanceId(caseInstance.getId())
                .orderByName().asc()
                .list();
        assertEquals(2, planItems.size());
        assertEquals("A", planItems.get(0).getName());
        assertEquals("B", planItems.get(1).getName());
        
        // Completing A should trigger exit criteria of B. Case completes.
        cmmnRuntimeService.triggerPlanItemInstance(planItems.get(0).getId());
        assertEquals(0, cmmnRuntimeService.createPlanItemQuery().count());
        assertEquals(0, cmmnRuntimeService.createCaseInstanceQuery().count());
        assertEquals(1, cmmnHistoryService.createHistoricCaseInstanceQuery().finished().count());
    }
    
    @Test
    @CmmnDeployment
    public void testSimpleExitCriteriaNonBlocking() {
        CaseInstance caseInstance = cmmnRuntimeService.startCaseInstanceByKey("myCase");
        assertEquals(0, cmmnRuntimeService.createPlanItemQuery().count());
        assertEquals(0, cmmnRuntimeService.createCaseInstanceQuery().count());
        assertEquals(1, cmmnHistoryService.createHistoricCaseInstanceQuery().finished().count());
        assertEquals(1, cmmnHistoryService.createHistoricCaseInstanceQuery().caseInstanceId(caseInstance.getId()).finished().count());
    }
    
    @Test
    @CmmnDeployment
    public void testSimpleExitCriteriaWithMultipleOnParts() {
        CaseInstance caseInstance = cmmnRuntimeService.startCaseInstanceByKey("myCase");
        List<PlanItemInstance> planItems = cmmnRuntimeService.createPlanItemQuery()
                .caseInstanceId(caseInstance.getId())
                .orderByName().asc()
                .list();
        assertEquals(5, planItems.size());
        String[] expectedNames = new String[] {"A", "B", "C", "D"};
        for (int i=0; i<4; i++) {
            assertEquals(expectedNames[i], planItems.get(i).getName());
            cmmnRuntimeService.triggerPlanItemInstance(planItems.get(i).getId());
        }
        
        assertEquals(0, cmmnRuntimeService.createPlanItemQuery().count());
        assertEquals(0, cmmnRuntimeService.createCaseInstanceQuery().count());
        assertEquals(1, cmmnHistoryService.createHistoricCaseInstanceQuery().finished().count());
    }
    
    @Test
    @CmmnDeployment
    public void testSimpleExitCriteriaWithMultipleOnParts2() {
        CaseInstance caseInstance = cmmnRuntimeService.startCaseInstanceByKey("myCase");
        List<PlanItemInstance> planItems = cmmnRuntimeService.createPlanItemQuery()
                .caseInstanceId(caseInstance.getId())
                .orderByName().asc()
                .list();
        assertEquals(5, planItems.size());
       
        // Triggering A and B exits C, which triggers the exit of D and E
        cmmnRuntimeService.triggerPlanItemInstance(planItems.get(0).getId());
        cmmnRuntimeService.triggerPlanItemInstance(planItems.get(1).getId());
        
        assertEquals(0, cmmnRuntimeService.createPlanItemQuery().count());
        assertEquals(0, cmmnRuntimeService.createCaseInstanceQuery().count());
        assertEquals(1, cmmnHistoryService.createHistoricCaseInstanceQuery().finished().count());
    }
    
}
