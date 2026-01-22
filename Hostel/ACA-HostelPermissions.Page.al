#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 70007 "ACA-Hostel Permissions"
{
    PageType = List;
    SourceTable = "ACA-Hostel Permissions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = Basic;
                }
                field("Can Allocate Room"; Rec."Can Allocate Room")
                {
                    ApplicationArea = Basic;
                }
                field("Can Check-Out"; Rec."Can Check-Out")
                {
                    ApplicationArea = Basic;
                }
                field("Can Switch Room"; Rec."Can Switch Room")
                {
                    ApplicationArea = Basic;
                }
                field("Can Transfer Student"; Rec."Can Transfer Student")
                {
                    ApplicationArea = Basic;
                }
                field("Can Reverse Allocation"; Rec."Can Reverse Allocation")
                {
                    ApplicationArea = Basic;
                }
                field("Can Print Invoice"; Rec."Can Print Invoice")
                {
                    ApplicationArea = Basic;
                }
                field("Can Create Hostel"; Rec."Can Create Hostel")
                {
                    ApplicationArea = Basic;
                }
                field("Can Create Room"; Rec."Can Create Room")
                {
                    ApplicationArea = Basic;
                }
                field("Can Create Room Space"; Rec."Can Create Room Space")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if not UserSetup.FindFirst then Error('Access denied!');
        if UserSetup."Hostel Admin" = false then Error('Access denied!');
    end;

    var
        UserSetup: Record "User Setup";
}

