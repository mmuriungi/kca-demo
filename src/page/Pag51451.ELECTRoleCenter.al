page 51451 "ELECT-Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(HOD; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }

        }
    }

    actions
    {
        area(creation)
        {
            action(Vote)
            {
                Caption = 'Vote';
                Image = PostedVoucherGroup;
                ApplicationArea = All;
                RunObject = Page "ELECT-Voter Login";

            }
            action(Setup)
            {
                Caption = 'Elections Setup';
                Image = WarehouseRegisters;
                ApplicationArea = All;
                RunObject = Page "ELECT-Elections Setup";
            }
            action(Elections)
            {
                Caption = 'Elections';
                Image = GetLines;
                ApplicationArea = All;
                RunObject = Page "ELECT-Elections Header List";
            }
        }
    }
}

