page 51935 "Audit-Risk Analysis Lines"
{
    PageType = ListPart;
    SourceTable = "AUDIT-Risk analysis Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Departmant Name"; Rec."Departmant Name")
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                }
                field(Likelihood; Rec.Likelihood)
                {
                    ApplicationArea = All;
                }
                field(Impact; Rec.Impact)
                {
                    ApplicationArea = All;
                }
                field("Overall Rating"; Rec."Overall Rating")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
                field(Risks; Rec.Risks)
                {
                    ApplicationArea = All;
                }
                field(Causes; Rec.Causes)
                {
                    ApplicationArea = All;
                }
                field("Risk Action"; Rec."Risk Action")
                {
                    ApplicationArea = All;
                }
                field("Responsible Persons"; Rec."Responsible Persons")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

