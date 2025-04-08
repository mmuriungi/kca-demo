page 50452 "Consolidated Risk List"
{
    CardPageID = "Consolidated Risk Card";
    PageType = List;
    // Caption = 'Rejected Risks List';
    SourceTable = "Risk Header";
    DeleteAllowed = false;
    //SourceTableView = where(Status = filter(New | "Pending Approval" | Released));
    SourceTableView = where("Plan Type" = const("Organizational Plan"), Status = filter(New | "Pending Approval" | Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {

                }
                field("Date Created"; "Date Created")
                {
                }
                field("Created By"; "Created By")
                {
                }
                field("Audit Period"; "Audit Period")
                {

                }
                // field("Risk Description2"; "Risk Description2")
                // {
                //     Caption = 'Objective';
                // }
                // field("Employee No."; "Employee No.")
                // {
                // }
                // field("Employee Name"; "Employee Name")
                // {
                // }
                field("Current Plan";"Current Plan")
                {

                }
                field(Comment;Comment)
                {

                }
                field("Risk Description"; RiskNotesText)
                {
                    Visible=false;
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
        /*
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup."Risk Admin" THEN
              BEGIN
                FILTERGROUP(2);
                SETRANGE("Created By",USERID);
              END;
          END ELSE
            ERROR('The User %1 does not exist in the User Setup',USERID);
        */

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('You Are Not Allowed To Delete A Record');
    end;

    var
        UserSetup: Record "User Setup";
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

