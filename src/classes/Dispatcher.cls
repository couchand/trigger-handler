global class Dispatcher
{
    global static void handle( Schema.sObjectType objectType )
    {

        for ( Handler__c handler : getHandlers( '' + objectType ) )
        {
            if ( !handlesCurrentContext( handler ) ) continue;

            Type handlerClass = Type.forName( handler.Handler__c );
            Handler handlerInstance = (Handler)handlerClass.newInstance();

            List<sObject> records = getRecords( handlerInstance );
            handlerInstance.handleRecords( records );
        }
    }

    global static List<Handler__c> getHandlers( String objectType )
    {
        return (List<Handler__c>)Select.Field.isEqual( Handler__c.SObject_Type__c, objectType )
                                             .filter( Handler__c.getAll().values() );
    }

    global static Boolean handlesCurrentContext( Handler__c handler )
    {
        return (
            Trigger.isBefore && (
                Trigger.isInsert && handler.Before_Insert__c ||
                Trigger.isUpdate && handler.Before_Update__c ||
                Trigger.isDelete && handler.Before_Delete__c ||
                Trigger.isUndelete && handler.Before_Undelete__c
            ) ||
            Trigger.isAfter && (
                Trigger.isInsert && handler.After_Insert__c ||
                Trigger.isUpdate && handler.After_Update__c ||
                Trigger.isDelete && handler.After_Delete__c ||
                Trigger.isUndelete && handler.After_Undelete__c
            )
        );
    }

    global static List<sObject> getRecords( Handler handler )
    {
        Select.Filter selector = handler.getRecordSelector();

        if ( Trigger.isInsert )
        {
            return selector.filter( Trigger.new );
        }

        if ( Trigger.isDelete )
        {
            return selector.filter( Trigger.old );
        }

        return selector.filter( Trigger.new, Trigger.oldMap );
    }
}