global interface Handler
{
    Boolean isRelevantTo( SObject obj );
    List<SObject> operateOn( SObject obj );
}