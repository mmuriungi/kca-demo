page 50461 "Audit SetUp List"
{
    ApplicationArea = All;
    Caption = 'Audit SetUp List';
    CardPageId = "Audit Setup";
    PageType = List;
    SourceTable = "Audit Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Audit Nos."; Rec."Audit Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Audit Nos. field.';
                }
            }
        }
    }
}
