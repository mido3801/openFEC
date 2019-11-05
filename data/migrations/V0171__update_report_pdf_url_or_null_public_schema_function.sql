--
-- Add FRQ and F6 notices to report_pdf_url_or_null
-- function to generate pdf_url
--

CREATE OR REPLACE FUNCTION report_pdf_url_or_null(image_number text, report_year numeric, committee_type text, form_type text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
begin
    return case
        when image_number is not null and (
                report_year >= 2000 or
                (form_type in ('F3X', 'F3P') and report_year > 1993) or
                (form_type in ('F3', 'FRQ') and committee_type = 'H' and report_year > 1996)
            ) then report_pdf_url(image_number)
        else null
    end;
end
$$;

ALTER FUNCTION public.report_pdf_url_or_null(image_number text, report_year numeric, committee_type text, form_type text) OWNER TO fec;

