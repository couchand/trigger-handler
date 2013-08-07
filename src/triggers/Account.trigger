trigger Account on Account ( before insert, after insert, before update, after update, before delete, after delete )
{
    Trigger.Dispatcher.handle( Account.sObjectType );
}