<template>
  <Annonce :allowReactions="true" :canPublish="isDelegate" />
</template>

<script setup>
import Annonce from '../../../components/Annonce.vue';
import { useAuth } from '../../../composables/useAuth';

const { isDelegate } = useAuth();
</script>
