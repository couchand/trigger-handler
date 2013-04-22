global interface TriggerHandler
{
    Boolean isRelevantTo( SObject obj );
    List<SObject> operateOn( SObject obj );
}