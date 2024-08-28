page 51611 "Merged Reuest Card"
{
    Caption = 'Merged Reuest Card';
    PageType = Card;
    SourceTable = "FLT-Transport Requisition";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Transport Requisition No"; Rec."Transport Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Requisition No field.';
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Request field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Duration to be Away"; Rec."Duration to be Away")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration to be Away field.';
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field.';
                }
                field("No Of Passangers"; Rec."No Of Passangers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No Of Passangers field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Date of Trip"; Rec."Date of Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Trip field.';
                }
                field("Approval Stage"; Rec."Approval Stage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Stage field.';
                }
            }
            part("Merged Lines"; "Merged Request Lines")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Transport Requisition No");
            }
        }
    }
}
