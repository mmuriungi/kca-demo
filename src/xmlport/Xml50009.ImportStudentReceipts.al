xmlport 50009 "Import Student Receipts"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("ACA-Imp. Receipts Buffer"; "ACA-Imp. Receipts Buffer")
            {
                XmlName = 'Receipts';
                fieldelement(SN; "ACA-Imp. Receipts Buffer".SN)
                {
                }
                fieldelement(Serial; "ACA-Imp. Receipts Buffer"."Transaction Code")
                {
                }
                fieldelement(cheqno; "ACA-Imp. Receipts Buffer"."Cheque No")
                {
                }
                fieldelement(FName; "ACA-Imp. Receipts Buffer"."F Name")
                {
                }
                fieldelement(MName; "ACA-Imp. Receipts Buffer"."M Name")
                {
                }
                fieldelement(LName; "ACA-Imp. Receipts Buffer"."L Name")
                {
                }
                fieldelement(IDNo; "ACA-Imp. Receipts Buffer".IDNo)
                {
                }
                fieldelement(AdminNo; "ACA-Imp. Receipts Buffer"."Student No.")
                {
                }
                fieldelement(Amount; "ACA-Imp. Receipts Buffer".Amount)
                {
                }
                fieldelement(desc; "ACA-Imp. Receipts Buffer".Description)
                {
                }
                fieldelement(sem; "ACA-Imp. Receipts Buffer".Semester)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    IF TDate = 0D THEN
                        ERROR('Please select the Transactions date');
                    IF Sem = '' THEN
                        ERROR('Please select the Semester');

                    "ACA-Imp. Receipts Buffer".Date := TDate;
                    "ACA-Imp. Receipts Buffer".Name := "ACA-Imp. Receipts Buffer"."F Name" + ' ' + "ACA-Imp. Receipts Buffer"."M Name" + ' ' + "ACA-Imp. Receipts Buffer"."L Name";
                    "ACA-Imp. Receipts Buffer"."Transaction Code" := "ACA-Imp. Receipts Buffer"."Transaction Code" + '-' + "ACA-Imp. Receipts Buffer".SN;
                    "ACA-Imp. Receipts Buffer".Semester := Sem;
                    "ACA-Imp. Receipts Buffer".Description := 'HELB-' + Sem;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Transaction Date"; TDate)
                {
                }
                field(Semester; Sem)
                {
                    TableRelation = "ACA-Semesters";
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN;
        /* IF CompanyInformation."Last Posting Date"<>0D THEN
            TDate:=CompanyInformation."Last Posting Date";
          IF CompanyInformation."Last Semester"<>'' THEN
            Sem:=CompanyInformation."Last Semester"; */
    end;

    trigger OnPostXmlPort()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            IF TDate <> 0D THEN
                //CompanyInformation."Last Posting Date":=TDate;
                IF Sem <> '' THEN
                    //CompanyInformation."Last Semester":=Sem;
                    CompanyInformation.MODIFY;
        END;
    end;

    var
        TDate: Date;
        Sem: Code[20];
        CompanyInformation: Record 79;
}

