report 50572 "Lecturer Appointment Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Lecturer Appointment Letter.rdl';

    dataset
    {
        dataitem("HRM-Employee C"; "HRM-Employee C")
        {
            PrintOnlyIfDetail = true;
            column(pic; info.Picture)
            {
            }
            column(seq; seq)
            {
            }
            column(comp; 'MASENO UNIVERSITY')
            {
            }
            column(tittle; 'LECTURER APPOINTMENT LETTER')
            {
            }
            column(CompName; info.Name)
            {
            }
            column(CompAddress; info.Address)
            {
            }
            column(CompPhone; info."Phone No.")
            {
            }
            column(CompMail; info."E-Mail")
            {
            }
            column(CompHomePage; info."Home Page")
            {
            }
            column(EmpNo; "HRM-Employee C"."No.")
            {
            }
            column(EmpName; "HRM-Employee C"."First Name" + ' ' + "HRM-Employee C"."Middle Name" + ' ' + "HRM-Employee C"."Last Name")
            {
            }
            column(bonapettie; '***************************************** BON APETTIE *****************************************')
            {
            }
            dataitem("ACA-Lecturers Units - Old"; "ACA-Lecturers Units - Old")
            {
                DataItemLink = Lecturer = FIELD("No.");
                column("Program"; "ACA-Lecturers Units - Old".Programme)
                {
                }
                column(Stage; "ACA-Lecturers Units - Old".Stage)
                {
                }
                column(UnitCode; "ACA-Lecturers Units - Old".Unit)
                {
                }
                column(UnitName; "ACA-Lecturers Units - Old".Description)
                {
                }
                column(Sem; "ACA-Lecturers Units - Old".Semester)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        DateFilter := TODAY;
    end;

    trigger OnPreReport()
    begin
        info.RESET;
        IF info.FIND('-') THEN BEGIN
            info.CALCFIELDS(info.Picture);
        END;
        CLEAR(seq);
    end;

    var
        DateFilter: Date;
        CafeSections: Option " ",Students,Staff;
        info: Record "Company Information";
        seq: Integer;
}

