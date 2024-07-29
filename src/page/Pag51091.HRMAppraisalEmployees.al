page 51091 "HRM-Appraisal Employees"
{
    Caption = 'Appraisal Employee List';
    Editable = false;
    PageType = List;
    SourceTable = "HRM-Employee C";

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Initials; Rec.Initials)
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Search Name"; Rec."Search Name")
                {
                }
                field("Postal Address"; Rec."Postal Address")
                {
                }
                field("Residential Address"; Rec."Residential Address")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                    Visible = false;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    Visible = false;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    Visible = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Visible = false;
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record 18;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
            Cust.FIND('-');
            WHILE CustCount > 0 DO BEGIN
                CustCount := CustCount - 1;
                Cust.MARKEDONLY(FALSE);
                FirstCust := Cust."No.";
                LastCust := FirstCust;
                More := (CustCount > 0);
                WHILE More DO
                    IF Cust.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Cust.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastCust := Cust."No.";
                            CustCount := CustCount - 1;
                            IF CustCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstCust = LastCust THEN
                    SelectionFilter := SelectionFilter + FirstCust
                ELSE
                    SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
                IF CustCount > 0 THEN BEGIN
                    Cust.MARKEDONLY(TRUE);
                    Cust.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;

    procedure SetSelection(var Cust: Record 18)
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;
}

