page 50667 "prPCA list"
{
    CardPageID = prPayChangeAdvice;
    PageType = List;
    SourceTable = "prBasic pay PCA";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Change Advice Serial No."; Rec."Change Advice Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }

                field(Effected; Rec.Effected)
                {
                    ApplicationArea = All;
                }
                field(PAyrollCode; Rec.PAyrollCode)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        // objOcx: Codeunit "70134708";
        Text19057798: Label 'e.g   C:\monte\Timesheets\main folder\';
        Text19037672: Label 'e.g   E:\monte\Back Up\Timesheets\';
        Text19075848: Label 'NB:  if ticked, system deletes the imported files from the "Primary Directory"';
        Text19036653: Label 'To view imported details, go to: "Salary Card" > "Other Info" > "Cost Centers"';
}

