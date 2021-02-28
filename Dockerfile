FROM infracloudio/csvserver
RUN touch /csvserver/inputdata
COPY inputFile /csvserver/inputdata
RUN chmod +x /csvserver/csvserver
RUN cd /csvserver
RUN ./csvserver
EXPOSE 9300
CMD /bin/bash
