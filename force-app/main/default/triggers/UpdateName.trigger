trigger UpdateName on BusinessLicense (Before Insert) {
    for(BusinessLicense obj : Trigger.New){
        obj.Name = 'TLC'+obj.Name;
    }
}