page 54854 "HMS-Immunization Posted List"
{
    CardPageID = "HMS Immunization Posted";
    Editable = false;
    PageType = List;
    SourceTable = "HMS-Immunization";
    SourceTableView = WHERE(Posted = CONST(true));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Immunization Date"; Rec."Immunization Date")
                {
                    ApplicationArea = All;
                }
                field("Immunization Time"; Rec."Immunization Time")
                {
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Patient.RESET;
                        IF Patient.GET(Rec."Patient No.") THEN BEGIN
                            Rec."Patient Name" := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                        END;
                    end;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Immunization No."; Rec."Immunization No.")
                {
                    ApplicationArea = All;
                }
                field("Immunization Name"; Rec."Immunization Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Given; Rec.Given)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        Patient: Record "HMS-Patient";
        Imm: Record "HMS-Immunization";
}

