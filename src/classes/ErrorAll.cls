public class ErrorAll implements Handler
{
    public Select.Filter getRecordSelector()
    {
        return new Select.Filter( new Select.ConstantPredicate( true ) );
    }

    public void handleRecords( List<sObject> records )
    {
        for ( sObject record : records )
        {
            record.addError( 'Error added by ErrorAll trigger handler' );
        }
    }
}