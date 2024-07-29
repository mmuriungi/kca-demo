page 51153 "PRL-Employee History"
{
    PageType = List;
    SourceTable = "PRL-Employee P9 Info";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    Editable = false;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    Editable = false;
                }
                field("Gross Pay"; Rec."Gross Pay")
                {
                    Editable = false;
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    Editable = false;
                }
                field(Allowances; Rec.Allowances)
                {
                    Editable = false;
                }
                field(Deductions; Rec.Deductions)
                {
                    Editable = false;
                }
                field(PAYE; Rec.PAYE)
                {
                    Editable = false;
                }
                field(NSSF; Rec.NSSF)
                {
                    Editable = false;
                }
                field(NHIF; Rec.NHIF)
                {
                    Editable = false;
                }
                field("Tax On Excess Pension"; Rec."Tax On Excess Pension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax On Excess Pension field.';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

