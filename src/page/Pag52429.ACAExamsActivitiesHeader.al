page 52429 "ACA-Exams Activities Header"
{
    PageType = Card;
    SourceTable = "ACA-Exams Activites Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
#pragma warning disable AL0269
                part(Eactv; "ACA-Exams Activities Lines")
#pragma warning restore AL0269
                {
                    SubPageLink = Code = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

