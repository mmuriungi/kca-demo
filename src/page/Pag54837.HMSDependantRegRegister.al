page 54837 "HMS Dependant Reg Register"
{
    PageType = ListPart;
    SourceTable = "HMS-Patient";
    SourceTableView = WHERE("Patient Type" = CONST(Employee),
                            Blocked = CONST(true),
                            "Request Registration" = CONST(true),
                            Registered = CONST(false),
                            Status = CONST("HOD Medical Approved"));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.Registered = FALSE THEN BEGIN
                            Rec.Blocked := TRUE;
                        END
                        ELSE BEGIN
                            IF CONFIRM('Register the dependant?') = FALSE THEN BEGIN EXIT END;
                            /*Check if the limit for the dependants has been reached*/
                            HMSSetup.RESET;
                            HMSSetup.GET();
                            IntD := HMSSetup."Limit Of Next Of Kin";

                            Dependant.RESET;
                            Dependant.SETRANGE(Dependant."Patient Type", Dependant."Patient Type"::Employee);
                            IF Dependant.FIND('-') THEN BEGIN
                                                            REPEAT
                                                                IF Dependant.Blocked = FALSE THEN BEGIN
                                                                    IF Dependant."Employee No." = Rec."Employee No." THEN BEGIN
                                                                        IntC := IntC + 1;
                                                                    END;
                                                                END;
                                                            UNTIL Dependant.NEXT = 0;
                            END;
                            IntC := IntC + 1;
                            IF IntC > IntD THEN BEGIN
                                ERROR('Employee currently has ' + FORMAT(HMSSetup."Limit Of Next Of Kin") + ' dependants. Registration not allowed');
                            END;
                            Rec.Blocked := FALSE;
                        END;
                        Rec.MODIFY;

                    end;
                }
                field("Request Registration"; Rec."Request Registration")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Photo; Rec.Photo)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        HMSSetup: Record "HMS-Setup";
        Dependant: Record "HMS-Patient";
        IntC: Integer;
        IntD: Integer;
}

