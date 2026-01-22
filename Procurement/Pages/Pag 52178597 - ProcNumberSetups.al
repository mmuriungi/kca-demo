page 52178597 "Proc Number Setups"
{
    Caption = 'Proc Number Setups';
    PageType = List;
    SourceTable = "Proc Number Setups";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Doc Type"; Rec."Doc Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Doc Type field.';
                }
                field("Institution Code"; Rec."Institution Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution Code field.';
                }
                field(Prefix; Rec.Prefix)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prefix field.';
                }
                field(FY; Rec.FY)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FY field.';
                }
                field("Number Series"; Rec."Number Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number Series field.';
                }
            }
        }
    }
}
