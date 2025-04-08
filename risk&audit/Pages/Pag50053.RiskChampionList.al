page 50053 "Risk Champion List"
{
    CardPageID = "Risk Card";
    PageType = List;
    SourceTable = "Risk Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Description"; RiskNotesText)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        CALCFIELDS("Risk Description");
                        "Risk Description".CREATEINSTREAM(Instr);
                        RiskNote.READ(Instr);

                        IF RiskNotesText <> FORMAT(RiskNote) THEN BEGIN
                            CLEAR("Risk Description");
                            CLEAR(RiskNote);
                            RiskNote.ADDTEXT(RiskNotesText);
                            "Risk Description".CREATEOUTSTREAM(OutStr);
                            RiskNote.WRITE(OutStr);
                        END;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        CALCFIELDS("Risk Description");
        "Risk Description".CREATEINSTREAM(Instr);
        RiskNote.READ(Instr);
        RiskNotesText := FORMAT(RiskNote);
    end;

    trigger OnOpenPage()
    begin
        /* if not UserSetup.Get(UserId) THEN
            ERROR(UserNotFoundErr, USERID)
        else begin
            if not UserSetup."Risk Admin" then begin
                RiskChampion.Reset();
                RiskChampion.SetRange("User ID", UserId);
                if RiskChampion.FindFirst() then begin
                    FilterGroup(2);
                    SetRange("Risk Region", RiskChampion."Shortcut Dimension 1 Code");
                end;
            end;
        end; */
    end;

    var
        UserSetup: Record "User Setup";
        RiskChampion: Record "Internal Audit Champions";
        UserNotFoundErr: Label 'The User Name %1 does not exist in the User Setup.';
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

