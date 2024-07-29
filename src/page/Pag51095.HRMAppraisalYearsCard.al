page 51095 "HRM-Appraisal Years Card"
{
    PageType = Card;
    SourceTable = "HRM-Appraisal Years";

    layout
    {
        area(content)
        {
            group(general)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Closed; Rec.Closed)
                {

                    trigger OnValidate()
                    begin
                        CurrentOnPush;
                    end;
                }
                field("Closed By"; Rec."Closed By")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }

    var
        AcademicY: Record "HRM-Appraisal Years";

    local procedure CurrentOnPush()
    begin
        IF Rec.Closed = TRUE THEN BEGIN
            IF CONFIRM('Are you sure you want to make ' + Rec.Code + ' as the current  year?') THEN BEGIN
                AcademicY.RESET;
                IF AcademicY.FIND('-') THEN BEGIN
                    REPEAT
                        IF AcademicY.Code <> Rec.Code THEN BEGIN
                            AcademicY.Closed := FALSE;
                            AcademicY.MODIFY;
                        END;
                    UNTIL AcademicY.NEXT = 0;
                END;
            END;
        END;
    end;
}

