global interface Handler
{
    Select.Filter recordSelector();
    void handleRecords( List<sObject> records );
}