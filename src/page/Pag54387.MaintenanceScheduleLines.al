page 54387 "Maintenance Schedule Lines"
{
    Caption = 'Maintenance Schedule Lines';
    PageType = List;
    SourceTable = "Maintenance Schedule Line";
    CardPageId = "Repair Request";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request No. field.';
                }
                field("Request Description"; Rec."Request Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Description field.';
                }
                field("Maintenance Officers"; Rec."Maintenance Officers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance Officers field.';
                }
                field("Requested Items/Assets"; Rec."Requested Items/Assets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Items/Assets field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field(Notified; Rec.Notified)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Expected Start Date"; Rec."Expected Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Start Date field.';
                }
                field("Expected End Date"; Rec."Expected End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected End Date field.';
                }
            }
        }
    }
}
