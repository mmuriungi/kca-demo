report 50671 "ELECT-Poll Agents"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ELECT-Poll Agents.rdl';

    dataset
    {
        dataitem(ElectDist; "ELECT-Electoral Districts")
        {
            DataItemTableView = SORTING("Election Code", "Electral District Doce");
            PrintOnlyIfDetail = true;
            column(ElectHeader; ELECTElectionsHeader."Election Description")
            {
            }
            column(CompNames; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(COmpPhone; CompanyInformation."Phone No." + ' ' + CompanyInformation."Phone No. 2")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompMail; CompanyInformation."Home Page" + ', ' + CompanyInformation."E-Mail")
            {
            }
            column(ElectralCode; ElectDist."Election Code")
            {
            }
            column(RetElectralDistrict; ElectDist."Electral District Doce")
            {
            }
            dataitem(ElectPollCent; "ELECT-Polling Centers")
            {
                DataItemLink = "Election Code" = FIELD("Election Code"),
                               "Electral District" = FIELD("Electral District Doce");
                DataItemTableView = SORTING("Election Code", "Polling Center Code")
                                    ORDER(Ascending);
                PrintOnlyIfDetail = true;
                column(RetPollingCent; ElctRet."Polling Center")
                {
                }
                column(RetOfficerId; ElectPollCent."Returning Officer ID")
                {
                }
                column(RetOfficerName; ElectPollCent."Returning Officer Name")
                {
                }
                dataitem(ElctRet; "ELECT-Poll Agents")
                {
                    DataItemLink = "Election Code" = FIELD("Election Code"),
                                   "Electral District" = FIELD("Electral District"),
                                   "Polling Center" = FIELD("Polling Center Code");
                    DataItemTableView = WHERE("Candidate No." = FILTER(<> ''),
                                              "National ID" = FILTER(<> ''));
                    RequestFilterFields = "Election Code", "Electral District", "Polling Center", "Candidate No.";
                    column(seq; seq)
                    {
                    }
                    column(RetId; ElctRet."National ID")
                    {
                    }
                    column(RetNames; ElctRet.Names)
                    {
                    }
                    column(CandNo; ElctRet."Candidate No.")
                    {
                    }
                    column(CandName; ElctRet."Candidate Name")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        seq := seq + 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(seq);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ELECTElectionsHeader.RESET;
                ELECTElectionsHeader.SETRANGE("Election Code", ElctRet."Election Code");
                IF ELECTElectionsHeader.FIND('-') THEN BEGIN
                END;
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
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        CompanyInformation: Record "Company Information";
        ELECTElectionsHeader: Record "ELECT-Elections Header";
        seq: Integer;
}

