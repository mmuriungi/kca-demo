page 51027 "DRE Extension List"
{
    Caption = 'DRE Extension List';
    CardPageId = "DRE extension Request";
    PageType = List;
    SourceTable = "Extension Services";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Requested Date"; Rec."Requested Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Date field.', Comment = '%';
                }
                field("Requested Staff ID"; Rec."Requested Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Staff ID field.', Comment = '%';
                }
                field("Service Requested"; Rec."Service Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Requested field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
