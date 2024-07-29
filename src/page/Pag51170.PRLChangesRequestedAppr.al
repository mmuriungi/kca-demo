page 51170 "PRL-Changes Requested Appr"
{
    Editable = false;
    PageType = List;
    SourceTable = "PRL-Payroll Variations";
    SourceTableView = WHERE(Status = FILTER(Approved));

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                }
                field("Effective Date"; Rec."Effective Date")
                {
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                }
                field("New Amount"; Rec."New Amount")
                {
                }
                field("Hrs Worked"; Rec."Hrs Worked")
                {
                }
                field("Overtime Type"; Rec."Overtime Type")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Approved By"; Rec."Approved By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

