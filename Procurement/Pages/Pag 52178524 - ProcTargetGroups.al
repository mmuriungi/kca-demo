page 52178524 "Proc-Target Groups"
{
    Caption = 'Proc-Target Groups';
    PageType = List;
    SourceTable = "Proc-Target Groups";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
