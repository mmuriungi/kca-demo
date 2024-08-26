/// <summary>
/// Page Perfomace Review (ID 50015).
/// </summary>
page 50714 "Perfomace Review"
{
    Caption = 'Perfomace Review';
    PageType = Listpart;
    SourceTable = "Perfomance Review";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisal No field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field.';
                }

                field(Period; Rec.Period)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period field.';
                }
                field("Review Period"; Rec."Review Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Review Period field.';
                }
                field("Agreed Targets"; Rec."Agreed Targets")
                {
                    
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agreed Targets field.';
                }
                field(KPIs; Rec.KPIs)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the KPIs field.';
                }
                field("Changed Targets"; Rec."Changed Targets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Changed Targets field.';
                }
                field("Level of achievement"; Rec."Level of achievement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Level of achievement field.';
                }
            }
        }
    }
}
