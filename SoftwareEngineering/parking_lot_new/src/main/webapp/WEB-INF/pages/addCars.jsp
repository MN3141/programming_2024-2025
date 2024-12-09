<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:pageTemplate pageTitle="Add car">
<form class="needs-validation" novalidate="" method="POST" action="${pageContext.request.contextPath}/AddCar">
    <div class="row g-3">
        <div class="col-sm-6">
            <label for="license_plate">Licence plate</label>
            <input type="text" class="form-control" id="license_plate"  name="license_plate" placeholder="" value="" required="">
            <div class="invalid-feedback">
                License plate is required.
            </div>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-sm-6">
            <label for="parking_spot">Parking spot</label>
            <input type="text" class="form-control" id="parking_spot"  name="license_plate" placeholder="" value="" required="">
            <div class="invalid-feedback">
                Parking spot is required.
            </div>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-sm-6">
            <label for="owner_id">Owner</label>
            <select id="owner_id" name="owner_id">
            </select>
        </div>
    </div>

    <div class="row g-3">
        <button class="btn btn-primary btn-lg" type="submit">Save</button>
    </div>
</form>

</t:pageTemplate>