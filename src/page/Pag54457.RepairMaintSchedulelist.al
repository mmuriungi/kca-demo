page 54457 "Repair Maint Schedule list"
{
    Caption = 'Repair Maint Schedule list';
    PageType = List;
    CardPageId = "Repair Main  Schedule Card";
    SourceTable = "Repair Maintenance  Schedule";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Reg No"; Rec."Reg No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reg No field.', Comment = '%';
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Make field.', Comment = '%';
                }
                field(Milleage; Rec.Milleage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Milleage field.', Comment = '%';
                }
                field("Nature Of Repair"; Rec."Nature Of Repair")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nature Of Repair field.', Comment = '%';
                }
                field("Date Of Repair"; Rec."Date Of Repair")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Of Repair field.', Comment = '%';
                }
                field("Amount "; Rec."Amount ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Comments By TO"; Rec."Comments By TO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments By TO field.', Comment = '%';
                }
            }
        }
    }
}
