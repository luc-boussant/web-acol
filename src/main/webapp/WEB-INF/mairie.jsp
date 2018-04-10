<%-- 
    Document   : mairie
    Created on : Apr 3, 2018, 5:07:03 PM
    Author     : boussanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mairie</title>
    </head>
    <body>
        <h1>Vous êtes bien connectés</h1>
        <!-- Afficher le catalogue des activités -->
        <h2>Activités</h2>
        <table border="1">
            <tr>
                <th>Nom</th>
                <th>Créneaux</th>
                <th>Classe</th>
                <th>Prix</th>
                <th>Effectif</th>
                <th>Mail de l'accompagnateur 1</th>
                <th>Mail de l'accompagnateur 2</th>
            </tr>
            <c:forEach items="${activites}" var="activite">
                <tr>
                    <td>${activite.getNom()}</td>
                    <td>${activite.getCreneaux()}</td>
                    <td>${activite.getClasse()}</td>
                    <td>${activite.getPrix()}</td>
                    <td>${activite.getEffectif()}</td>
                    <td>${activite.getAccompagnateur1()}</td>
                    <td>${activite.getAccompagnateur2()}</td>
                    <td><a href="controleurMairie?action=activiteSupprimer&actiNom=${activite.getNom()}&actiCreneaux=${activite.getCreneaux()}">supprimer</a></td>
                </tr>
            </c:forEach>
        </table>
        <br/>
        <h3>Ajouter une activité</h3>
        <form method="get" action="controleurMairie" accept-charset="UTF-8">
            Nom de l'activité : <input type="text" name="nom" required/>
            <br/>
            Creneaux de l'activite : <input type='text' name="creneaux" required/>
            <br/>
            Classe(s) concernées : <input type='text' name="classes" required/>
            <br/>
            Prix de l'activité : <input type='number' name="prix" min=0 required/>
            <br/>
            Effectif de l'activité : <input type='number' name="effectif" min=0 required/>
            <br/>
            Accompagnateur 1 :
                <select name="mail1" required>
                    <c:forEach items="${accompagnateurs}" var="accompagnateur">
                        <option value="${accompagnateur}">${accompagnateur}</option>
                    </c:forEach>   
                </select>
            <br/>
            Accompagnateur 2 :
                <select name="mail2" required>
                    <c:forEach items="${accompagnateurs}" var="accompagnateur">
                        <option value="${accompagnateur}">${accompagnateur}</option>
                    </c:forEach>   
                </select>
            <br/>
            <input type="submit" value="Ajouter" />
            <!-- Pour indiquer au contrôleur quelle action faire, on utilise un champ caché -->
            <input type="hidden" name="action" value="activiteAjouter" />
        </form>
        <!-- Afficher les regimes -->
        <h2>Regime</h2>
        <table border="1">
            <c:forEach items="${regimes}" var="regime">
                <tr>
                    <td>${regime}</td>
                    <td><a href="controleurMairie?action=regimeSupprimer&regime=${regime}">supprimer</a></td>
                </tr>
            </c:forEach>                            
        </table>
        <br/>
        <h3>Ajouter un régime</h3>
          <form method="get" action="controleurMairie" accept-charset="UTF-8">
              Regime à ajouter : <input type="text" name="regime" required/>
            <input type="submit" value="Ajouter" />
            <!-- Pour indiquer au contrôleur quelle action faire, on utilise un champ caché -->
            <input type="hidden" name="action" value="regimeAjouter" />
          </form>

    </body>
</html>
