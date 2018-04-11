/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controleur;

import dao.ActiviteDAO;
import dao.DAOException;
import dao.PeriodeDAO;
import dao.EmployeDAO;
import dao.RegimeDAO;
import dao.AccompagnateurDAO;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;
import modele.Activite;
import modele.Periode;
import modele.FicheParent;

/**
 * Le contrôleur de l'application.
 */
@WebServlet(name = "ControleurMairie", urlPatterns = {"/controleurMairie"})
public class ControleurMairie extends HttpServlet {

    @Resource(name = "jdbc/bibliography")
    private DataSource ds;

    /* pages d’erreurs */
    private void invalidParameters(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/controleurErreur.jsp").forward(request, response);        
    }

    private void erreurBD(HttpServletRequest request,
                HttpServletResponse response, DAOException e)
            throws ServletException, IOException {
        e.printStackTrace(); // permet d’avoir le détail de l’erreur dans catalina.out
        request.setAttribute("erreurMessage", e.getMessage());
        request.getRequestDispatcher("/WEB-INF/bdErreur.jsp").forward(request, response);
    }
  
    /**
     * Actions possibles en GET : Supprimer Regime, Ajouter Regime
     */
    public void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        RegimeDAO regimeDAO = new RegimeDAO(ds);
        ActiviteDAO activiteDAO = new ActiviteDAO(ds);
        AccompagnateurDAO accompagnateurDAO = new AccompagnateurDAO(ds);
        PeriodeDAO periodeDAO = new PeriodeDAO(ds);
        String action = request.getParameter("action");
        if (action.equals("regimeSupprimer")) {
            regimeDAO.supprimerRegime(request.getParameter("regime"));
            List<String> regimes = regimeDAO.getListeRegime();
            List<Activite> activites = activiteDAO.getListeActivite();
            List<Periode> periodes = periodeDAO.getPeriodes();
            request.setAttribute("regimes", regimes);
            List<String> accompagnateurs = accompagnateurDAO.getListEmail();
            request.setAttribute("accompagnateurs", accompagnateurs);
            request.setAttribute("activites", activites);
            request.setAttribute("periodes", periodes);
            request.getRequestDispatcher("/WEB-INF/mairie.jsp").forward(request, response);
        } else if (action.equals("regimeAjouter")) {
            regimeDAO.ajouterRegime(request.getParameter("regime"));
            List<String> regimes = regimeDAO.getListeRegime();
            List<Activite> activites = activiteDAO.getListeActivite();
            List<Periode> periodes = periodeDAO.getPeriodes();
            request.setAttribute("regimes", regimes);
            List<String> accompagnateurs = accompagnateurDAO.getListEmail();
            request.setAttribute("accompagnateurs", accompagnateurs);
            request.setAttribute("activites", activites);
            request.setAttribute("periodes", periodes);
            request.getRequestDispatcher("/WEB-INF/mairie.jsp").forward(request, response);
        } else if (action.equals("activiteAjouter")) {
            activiteDAO.ajouterActivite(request.getParameter("nom"), request.getParameter("creneauxJour"), request.getParameter("creneauxHeure"),
                                         request.getParameter("classes"), Integer.parseInt(request.getParameter("prix")),
                                          Integer.parseInt(request.getParameter("effectif")), request.getParameter("mail1"),
                                          request.getParameter("mail2"));
            List<Activite> activites  = activiteDAO.getListeActivite();
            request.setAttribute("activites", activites);
            List<String> accompagnateurs = accompagnateurDAO.getListEmail();
            request.setAttribute("accompagnateurs", accompagnateurs);
            request.getRequestDispatcher("/WEB-INF/mairie.jsp").forward(request, response);
        } else if (action.equals("periodeSupprimer")) {
            periodeDAO.supprimerPeriode(request.getParameter("dateDebut"), request.getParameter("dateFin"));
            List<String> regimes = regimeDAO.getListeRegime();
            List<Activite> activites = activiteDAO.getListeActivite();
            List<Periode> periodes = periodeDAO.getPeriodes();
            request.setAttribute("regimes", regimes);
            request.setAttribute("activites", activites);
            request.setAttribute("periodes", periodes);
            request.getRequestDispatcher("/WEB-INF/mairie.jsp").forward(request, response);
        } else if (action.equals("periodeAjouter")) {
            periodeDAO.ajouterPeriode(request.getParameter("dateDebut"), request.getParameter("dateFin"));
            List<String> regimes = regimeDAO.getListeRegime();
            List<Activite> activites = activiteDAO.getListeActivite();
            List<Periode> periodes = periodeDAO.getPeriodes();
            request.setAttribute("regimes", regimes);
            request.setAttribute("activites", activites);
            request.setAttribute("periodes", periodes);
            request.getRequestDispatcher("/WEB-INF/mairie.jsp").forward(request, response);
        } else if (action.equals("logout")) {
            request.logout();
            response.sendRedirect("index.jsp");
        }
    }
    
    /**
     * Actions possibles en POST : connexion
     */
    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        RegimeDAO regimeDAO = new RegimeDAO(ds);
        ActiviteDAO activiteDAO = new ActiviteDAO(ds);
        AccompagnateurDAO accompagnateurDAO = new AccompagnateurDAO(ds);
        PeriodeDAO periodeDAO = new PeriodeDAO(ds);
        EmployeDAO employeDAO = new EmployeDAO(ds);
        if (action == null) {
            invalidParameters(request, response);
            return;
            
        } else if (action.equals("connexion")) {
            // tester si mdp et login corrects
            String login = request.getParameter("login");
            String mdp = request.getParameter("password");
            if (employeDAO.verify(login, mdp)) {
                List<String> regimes = regimeDAO.getListeRegime();
                List<Activite> activites = activiteDAO.getListeActivite();
                request.setAttribute("regimes", regimes);
                request.setAttribute("activites", activites);
                request.setAttribute("login",login);
                request.getRequestDispatcher("/WEB-INF/mairie.jsp").forward(request, response);
            } else {
                request.setAttribute("erreurLoginMairie", "1");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        }else if (action.equals("creationCompteMairie")) {
            if(!request.getParameter("password1").equals(request.getParameter("password2"))){
                request.setAttribute("differentPassword", "1");
                request.getRequestDispatcher("/WEB-INF/mairie.jsp").forward(request, response);
            }
            else if(employeDAO.verifyLogin(request.getParameter("login"))){
                request.setAttribute("loginUsed", "1");
                request.getRequestDispatcher("/WEB-INF/mairie.jsp").forward(request, response);
            }
            employeDAO.creation(request.getParameter("login"), request.getParameter("password1") );
            List<String> regimes = regimeDAO.getListeRegime();
            List<Activite> activites = activiteDAO.getListeActivite();
            List<String> accompagnateurs = accompagnateurDAO.getListEmail();
            request.setAttribute("regimes", regimes);
            request.setAttribute("activites", activites);
            request.setAttribute("accompagnateurs", accompagnateurs);
            List<Periode> periodes = periodeDAO.getPeriodes();
            request.setAttribute("regimes", regimes);
            request.setAttribute("activites", activites);
            request.setAttribute("periodes", periodes);
            request.getRequestDispatcher("/WEB-INF/mairie.jsp").forward(request, response);
            
        }


    }

}

