page 52880 "ACA-Evaluation Semesters List"
{
    CardPageID = "ACA-Evaluation Semesters Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ACA-Semesters";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    //Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    //Editable = false;

                }
                field("Current Semester"; Rec."Current Semester")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Rep)
            {
                Caption = 'Evaluation Report';
                Image = Statistics1099;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ACALecturersEvaluation.RESET;
                    ACALecturersEvaluation.SETRANGE(Semester, Rec.Code);
                    IF ACALecturersEvaluation.FIND('-') THEN BEGIN
                        REPORT.RUN(65251, TRUE, FALSE, ACALecturersEvaluation);
                    END;
                end;
            }
            action(EvSumm)
            {
                Caption = 'Evaluation Summary';
                Image = Aging;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ACALecturersEvaluation.RESET;
                    ACALecturersEvaluation.SETRANGE(Semester, Rec.Code);
                    IF ACALecturersEvaluation.FIND('-') THEN BEGIN
                        REPORT.RUN(65252, TRUE, FALSE, ACALecturersEvaluation);
                    END;
                end;
            }
        }
    }

    var
        ACALecturersEvaluation: Record "ACA-Lecterer Evalution";
}

