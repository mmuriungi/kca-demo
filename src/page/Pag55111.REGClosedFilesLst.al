page 55111 "REG-Closed Files Lst"
{
    ApplicationArea = All;
    Caption = 'REG-Closed Files Lst';
    PageType = List;
    SourceTable = "REG-Archives Register";
    UsageCategory = Administration;
    CardPageId = "REG-ClosedFiles Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("File Index"; Rec."File Index")
                {
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ToolTip = 'Specifies the value of the Closed Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ToolTip = 'Specifies the value of the Closed By field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Version"; Rec."Version")
                {
                    ToolTip = 'Specifies the value of the Version field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Folios"; Rec."Total Folios")
                {
                    ToolTip = 'Specifies the value of the Total Folios field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(EDMS)
            {
                ApplicationArea = All;
                Caption = 'Attach Folio';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                RunObject = Page "REG-Doc Attach Details";

                RunPageLink = "No." = field("File Index");
            }
        }
    }
}
