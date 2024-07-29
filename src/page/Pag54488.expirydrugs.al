page 54488 "expiry drugs"
{
    PageType = List;
    SourceTable = "Pharmacy Stock Header";

    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expiry Date field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Expiring Soon")
            {
                Caption = 'Show Expiring Soon';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    SetExpiryFilter();
                end;
            }
            action("Send Email Notifications")
            {
                Caption = 'Send Email Notifications';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    NotifyExpiringSoon();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetExpiryFilter();
    end;

    procedure SetExpiryFilter()
    var
        ExpiryDate: Date;
    begin
        ExpiryDate := Today() + 5;
        Rec.SetRange("Expiry Date", Today(), ExpiryDate);
    end;

    procedure NotifyExpiringSoon()
    var
        EmailNotification: Codeunit "Email Notification Codeunit";
    begin
        EmailNotification.SendExpiryNotifications(Rec);
    end;
}
