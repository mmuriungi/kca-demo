page 50239 "Audit Plan SubForm"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item & Key Annual output"; Rec."Item & Key Annual output")
                {
                    ApplicationArea = All;
                }
                field("Audit Objectives"; Rec."Audit Objectives")
                {
                    ApplicationArea = All;
                }
                field("Core Activities"; Rec."Core Activities")
                {
                    ApplicationArea = All;
                }
                field("Means of verification"; Rec."Means of verification")
                {
                    ApplicationArea = All;
                }
                field("Work Dates"; Rec."Work Dates")
                {
                    ApplicationArea = All;
                }
                field("Expected Report"; Rec."Expected Report")
                {
                    ApplicationArea = All;
                }
                field("Reporting Date"; Rec."Reporting Date")
                { 
                    ApplicationArea = All;
                }
                field(Responsibility; Rec.Responsibility)
                { 
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin



    end;

    trigger OnAfterGetRecord()
    begin

    end;

    var
}

