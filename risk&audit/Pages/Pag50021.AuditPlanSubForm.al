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

                }
                field("Core Activities"; Rec."Core Activities")
                {
                }
                field("Means of verification"; Rec."Means of verification")
                {

                }
                field("Work Dates"; Rec."Work Dates")
                {
                }
                field("Expected Report"; Rec."Expected Report")
                {
                }
                field("Reporting Date"; Rec."Reporting Date")
                { }
                field(Responsibility; Rec.Responsibility)
                { }
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

