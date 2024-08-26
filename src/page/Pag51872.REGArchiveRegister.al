page 51872 "REG-Archive Register"
{
    ApplicationArea = All;
    Caption = 'REG-Archive Register';
    PageType = List;
    SourceTable = "REG-Archives Register";
    UsageCategory = Administration;
    CardPageId = "REG-ArchiveRegister Card";
    // SourceTableView = where(Archived = const(true), "Marked for Destruction" = filter(= false));

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
                }
                field("Version"; Rec."Version")
                {
                    ToolTip = 'Specifies the value of the Version field.';
                    ApplicationArea = All;
                }
                field(Archived; Rec.Archived)
                {
                    ToolTip = 'Specifies the value of the Archived field.';
                    ApplicationArea = All;
                }
                field("Archived By"; Rec."Archived By")
                {
                    ToolTip = 'Specifies the value of the Archived By field.';
                    ApplicationArea = All;
                }
                field("Archived Date"; Rec."Archived Date")
                {
                    ToolTip = 'Specifies the value of the Archived Date field.';
                    ApplicationArea = All;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ToolTip = 'Specifies the value of the Closed Date field.';
                    ApplicationArea = All;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ToolTip = 'Specifies the value of the Closed By field.';
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
