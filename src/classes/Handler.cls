global interface Handler
{
    Select.Filter getRecordSelector();
    void handleRecords( List<sObject> records );
}