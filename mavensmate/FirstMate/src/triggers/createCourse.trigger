trigger createCourse on Opportunity (after update) {

    TriggerCentral.createCourseRecord(trigger.new, trigger.newMap, trigger.old, trigger.oldMap);
     

}