page 54844 "HMS Employee Dependant HR"
{
    PageType = Document;
    SourceTable = "HRM-Employee C";

    layout
    {
        area(content)
        {
            group(gr)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Ext."; Rec."Ext.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
            }
            part(Page; "HMS Employee Dependant SUB")
            {
                SubPageLink = "Employee No." = FIELD("No.");
                SubPageView = WHERE("Patient Type" = CONST(Employee),
                                    "Request Registration" = CONST(true),
                                    Blocked = CONST(true),
                                    Status = CONST("Request Made"));
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("&Approve Request")
                {
                    Caption = '&Approve Request';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Line.RESET;
                        Line.SETRANGE(Line.Status, Line.Status::"Request Made");
                        Line.SETRANGE(Line."Employee No.", Rec."No.");
                        Line.SETRANGE(Line.Select, TRUE);
                        IF Line.FIND('-') THEN BEGIN
                            IF CONFIRM('Do you wish to Approve the Selected requests?', TRUE) = FALSE THEN BEGIN EXIT END;
                                                   REPEAT
                                                       Line.Status := Line.Status::"HOD HR Approved";
                                                       Line.MODIFY;
                                                   UNTIL Line.NEXT = 0;
                            MESSAGE('The Selected Dependants Registration Request have been marked as Approved');
                        END;
                    end;
                }
                action("&Reject Request")
                {
                    Caption = '&Reject Request';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Line.RESET;
                        Line.SETRANGE(Line.Status, Line.Status::"Request Made");
                        Line.SETRANGE(Line."Employee No.", Rec."No.");
                        Line.SETRANGE(Line.Select, TRUE);
                        IF Line.FIND('-') THEN BEGIN
                            IF CONFIRM('Do you wish to Reject the Selected requests?', TRUE) = FALSE THEN BEGIN EXIT END;
                                                   REPEAT
                                                       Line.Status := Line.Status::"HOD HR Rejected";
                                                       Line.MODIFY;
                                                   UNTIL Line.NEXT = 0;
                            MESSAGE('The Selected Dependants Registration Request have been marked as REJECTED');
                        END;
                    end;
                }
            }
        }
    }

    var
        Line: Record "HMS-Patient";
}

